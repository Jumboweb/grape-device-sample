module GrapeDeviceSample
  class Base < Grape::API
    format :json
    prefix :api
    mount GrapeDeviceSample::V1::Users

    add_swagger_documentation(
      base_path: "",
      api_version: "v1",
      format: :json,
      hide_documentation_path: true,
      info: {
        title: "GrapeSampleDevice API",
        description: 'Amaizing',
        contact: "pjdalberto@jumboweb.fr",
        license: "All Rights Reserved"
        }
    )

  end
end
