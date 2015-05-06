module GrapeDeviceSample
  class Base < Grape::API
    mount GrapeDeviceSample::V1::Users
    
  end
end
