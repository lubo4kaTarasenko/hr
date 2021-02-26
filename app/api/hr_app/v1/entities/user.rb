class HrApp::V1::Entities::User < Grape::Entity
  expose :name
  expose :email
  expose :level
  expose :english_level
  expose :skills
end
