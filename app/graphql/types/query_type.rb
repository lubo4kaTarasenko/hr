module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    
    field :user, UserType, null: true do
      description "Find user"
      argument :email, String, required: true
    end

    field :users, [UserType], null: true do
      description "Find all"
      argument :first, Integer, required: false
      argument :english, String, required: false
    end


    def user(attrs)
      user = User.find_by(attrs)
      GraphqlInteractors::ExtractUserInfo.call(user: user).info
    end

    def users(attrs = {})      
      scope = User.all
      scope = scope.limit(attrs[:first]) if attrs[:first]
      scope = scope.where(english_level: attrs[:english]) if attrs[:english]
      extract_users_infos(scope)
    end

    private

    def extract_users_infos(scope)
      scope.includes(:personal_info, :skills, :vacations, :sick_leaves, :allocated_time_slots).map do |user|
        GraphqlInteractors::ExtractUserInfo.call(user: user).info
      end
    end        
  end
end
