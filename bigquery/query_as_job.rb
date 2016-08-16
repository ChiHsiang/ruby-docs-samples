#!/usr/bin/env ruby

# Copyright 2015 Google, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Samples
  # BigQuery Samples module
  module BigQuery
    # A short sample demonstrating making a BigQuery request as a job
    # This uses Application Default Credentials to authenticate.
    # @see https://cloud.google.com/bigquery/bigquery-api-quickstart
    class QueryAsJob
      def run_query_as_job project_id, sql
        require "gcloud"

        gcloud = Gcloud.new project_id
        bigquery = gcloud.bigquery

        # [START run_query]
        job = bigquery.query_job sql

        if job.failed?
          puts job.error
        else
          job.query_results.each_with_index do |row, index|
            puts "--- Row #{index+1} ---"
            for column, value in row
              puts "#{column}: #{value}"
            end
          end
        end
        # [END run_query]
      end
    end

    if __FILE__ == $PROGRAM_NAME
      if ARGV.length != 2
        puts "usage: tables.rb [project_id] [sql]"
      else
        project_id = ARGV.shift
        sql = ARGV.shift
        QueryAsJob.new.run_query_as_job project_id, sql
      end
    end
  end
end
