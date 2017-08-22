# Copyright 2015 Google, Inc
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

# [START create_pubsub_client]
require "google/cloud/pubsub"

pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
# [END create_pubsub_client]

def create_topic
  # [START create_topic]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"

  topic = pubsub.create_topic "my-topic"

  puts "Topic created #{topic.name}"
  # [END create_topic]
end

def delete_topic
  # [START delete_topic]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  topic.delete

  puts "Deleted topic my-topic"
  # [END delete_topic]
end

def create_subscription
  # [START create_subscription]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  subscription = topic.subscribe "my-subscription"

  puts "Subscription created #{subscription.name}"
  # [END create_subscription]
end

def delete_subscription
  # [START delete_subscription]
  # project_id = "Your Google Cloud project ID"

  pubsub       = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic        = pubsub.topic "my-topic"
  subscription = topic.subscription "my-subscription"

  subscription.delete

  puts "Deleted subscription my-subscription"
  # [END delete_subscription]
end

def create_push_subscription
  # [START create_push_subscription]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  subscription = topic.subscribe(
    "my-subscription-push",
    endpoint: "https://my-gcp-project-id.appspot.com/push"
  )

  puts "Push subscription created #{subscription.name}"
  # [END create_push_subscription]
end

def publish_message
  # [START publish_message]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  topic.publish "A Message"
  # [END publish_message]
end

def pull_messages
  # [START pull_messages]
  # project_id = "Your Google Cloud project ID"

  pubsub       = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  subscription = pubsub.subscription "my-subscription"

  puts "Messages pulled:"
  subscription.pull.each do |message|
    puts message.data
    message.acknowledge!
  end
  # [END pull_messages]
end

def list_topics
  # [START list_topics]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topics = pubsub.topics

  puts "Topics:"
  topics.each do |topic|
    puts topic.name
  end
  # [END list_topics]
end

def list_subscriptions
  # [START list_subscriptions]
  # project_id = "Your Google Cloud project ID"

  pubsub        = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  subscriptions = pubsub.subscriptions

  puts "Subscriptions:"
  subscriptions.each do |subscription|
    puts subscription.name
  end
  # [END list_subscriptions]
end

def get_topic_policy
  # [START get_topic_policy]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  policy = topic.policy

  puts "Topic policy:"
  puts policy.roles
  # [END get_topic_policy]
end

def get_subscription_policy
  # [START get_subscription_policy]
  # project_id = "Your Google Cloud project ID"

  pubsub       = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  subscription = pubsub.subscription "my-subscription"

  policy = subscription.policy

  puts "Subscription policy:"
  puts policy.roles
  # [END get_subscription_policy]
end

def set_subscription_policy
  # [START set_subscription_policy]
  # project_id = "Your Google Cloud project ID"

  pubsub       = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  subscription = pubsub.subscription "my-subscription"

  policy = subscription.policy do |p|
    p.add "roles/pubsub.subscriber",
          "serviceAccount:account-name@other-project.iam.gserviceaccount.com"
  end

  puts subscription.policy.roles
  # [END set_subscription_policy]
end

def set_topic_policy
  # [START set_topic_policy]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  policy = topic.policy do |p|
    p.add "roles/pubsub.publisher",
          "serviceAccount:account-name@other-project.iam.gserviceaccount.com"
  end

  puts topic.policy.roles
  # [END set_topic_policy]
end

def test_subscription_permissions
  # [START test_subscription_permissions]
  # project_id = "Your Google Cloud project ID"

  pubsub       = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  subscription = pubsub.subscription "my-subscription"

  permissions = subscription.test_permissions "pubsub.subscriptions.consume",
                                              "pubsub.subscriptions.update"

  puts permissions.include? "pubsub.subscriptions.consume"
  puts permissions.include? "pubsub.subscriptions.update"
  # [END test_subscription_permissions]
end

def test_topic_permissions
  # [START test_topic_permissions]
  # project_id = "Your Google Cloud project ID"

  pubsub = Google::Cloud::Pubsub.new project: "my-gcp-project-id"
  topic  = pubsub.topic "my-topic"

  permissions = topic.test_permissions "pubsub.topics.attachSubscription",
                                       "pubsub.topics.publish",
                                       "pubsub.topics.update"

  puts permissions.include? "pubsub.topics.attachSubscription"
  puts permissions.include? "pubsub.topics.publish"
  puts permissions.include? "pubsub.topics.update"
  # [END test_topic_permissions]
end
