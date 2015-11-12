(ns sn-backend.query
  (:gen-class))


(def ^{:dynamic true} *exec-mode* false)

(defn empty-query [ent]
  (let [ent (if (keyword? ent)
              (name ent)
              ent)
        [ent table alias db] (if (string? ent)
                               [{:table ent} ent nil nil]
                               [ent (:table ent) (:alias ent) (:db ent)])]
    {:ent ent
     :table table
     :db db
     :alias alias}))

(defmacro ^{:private true} make-query [ent m]
  `(let [ent# ~ent]
     (if (:type ent#)
       ent#
       (let [~'this-query (empty-query ent#)]
         (merge ~'this-query ~m)))))

(defn select*
  "Create a select query with fields provided in Ent.  If fields are not provided,
  create an empty select query. Ent can either be an entity defined by defentity,
  or a string of the table name"
  [ent]
  (let [default-fields (not-empty (:fields ent))]
    (make-query ent {:type :select
                     :fields (or default-fields [::*])
                     :from [(:ent this-query)]
                     :modifiers []
                     :joins []
                     :where []
                     :order []
                     :aliases #{}
                     :group []
                     :results :results})))

(defmacro select
  "Creates a select query, applies any modifying functions in the body and then
  executes it. `ent` is either a string or an entity created by defentity.
  ex: (select user
        (fields :name :email)
        (where {:id 2}))"
  [ent & body]
  (make-query-then-exec #'select* body ent))

(defn- make-query-then-exec [query-fn-var body & args]
  `(let [query# (-> (~query-fn-var ~@args)
                    ~@body)]
     (exec query#)))
