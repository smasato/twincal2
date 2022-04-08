# coding: utf-8

require 'sqlite3'
require 'csv'
require 'yaml'

def escape_sql(str)
  str ? "'#{str.gsub("'", "''")}'" : "''"
end

# usage: 
# $ rm kamoku.db
# $ ruby database_import.rb kdb_20140402080858_2.csv

csv_filename = ARGV[0]

CONFIG = YAML.load_file("../config.yml")
DATABASE_FILENAME = CONFIG["database"]["filename"]
COLUMN_NAMES = CONFIG["database"]["column_names"]
TABLE_NAME = CONFIG["database"]["table_name"]

db = SQLite3::Database.new(DATABASE_FILENAME)
db.busy_timeout(100000)

db.execute("create table #{TABLE_NAME} (id integer primary key, #{COLUMN_NAMES.map{|c| "#{c} text"}.join(',')})")
db.execute("create index code_index on #{TABLE_NAME}(course_number)")

table = []
File.foreach(csv_filename, encoding: 'CP932:UTF-8', headers: true) do |csv_line|
  # puts csv_line
  row = CSV.parse(csv_line.strip.gsub('\"', '""')).first
  table.push([row[0], row[1], row[3], row[5], row[6], row[7], row[8]])
end

row_count = 0

table.each do |row|
  str = "insert into #{TABLE_NAME}(#{COLUMN_NAMES.join(',')}) values(#{row.map{|s| escape_sql(s)}.join(",")})"
  # p str
  db.execute(str)

  row_count += 1
end

db.close

puts "正常に処理が終了しました。(#{row_count}件)"
