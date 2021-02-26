class HrApp::V1::Entities::Manager < HrApp::V1::Entities::User
  expose :hours
  expose :vacations
  expose :sick_leaves
  expose :time_slots
end
