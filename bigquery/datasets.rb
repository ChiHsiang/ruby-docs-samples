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
    # A short sample demonstrating listing BigQuery datasets
    # This uses Application Default Credentials to authenticate.
    # @see https://cloud.google.com/bigquery/bigquery-api-quickstart
    class Datasets
      def list_datasets project_id
        # [START list_datasets]
        require "gcloud"

        gcloud = Gcloud.new project_id
        bigquery = gcloud.bigquery

        bigquery.datasets.each do |dataset|
          puts "#{dataset.dataset_id}"
        end
        # [END list_datasets]
      end
    end

    if __FILE__ == $PROGRAM_NAME
      if ARGV.length != 1
        puts "usage: datasets.rb [project_id]"
      else
        project_id = ARGV.shift
        Datasets.new.list_datasets project_id
      end
    end
  end
end
