(defproject sn-backend "0.1.0-SNAPSHOT"
  :description "The backend of the Sort Night application, this is a restful web service."
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0"]
                 [org.clojure/java.jdbc "0.4.2"]
                 [ring "1.4.0"]
                 [ring/ring-json "0.4.0"]
                 [compojure "1.4.0"]
                 [korma "0.4.2"]
                 [dire "0.5.3"]
                 [mysql/mysql-connector-java "5.1.18"]
                 ]
  :main sn-backend.core)
