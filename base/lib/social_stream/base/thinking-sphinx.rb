module SocialStream
  module Base
    module ThinkingSphinx
      module ActiveRecord
        module Interpreter
          def subject_index
            indexes actor.name, :sortable => true
            indexes actor.email
            indexes actor.slug

            has created_at
            has Relation::Public.instance.id.to_s, :type => :integer, :as => :relation_ids
          end

          def activity_object_index
            indexes activity_object.title,       :as => :title
            indexes activity_object.description, :as => :description
            indexes activity_object.tags.name,   :as => :tags

            has created_at
=begin
            has author_actions(:actor_id), :as => :author_id
            has activity_object.owner_actions(:actor_id),  :as => :owner_id
            has activity_object.activity_object_audiences(:relation_id), :as => :relation_ids
=end
          end
        end
      end
    end
  end
end
