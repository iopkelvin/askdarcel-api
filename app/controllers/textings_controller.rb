class TextingsController < ApplicationController
  
  def create 

    # Make a post request to Textellent API
    response = post(textellent_params)

    if response['status'] == 'success'

      user = Texting.find_by(phone_number: db_params[:mobilePhone]) 
      # if the user previously used the Texting service and we have a record of their
      # phone number in our DB we just update the resources ids & tags and given name
      if user
        # using set to avoid the duplication of resources Ids requested from the same phone number.
        resources = Set.new(user[:resources]) << db_params[:resourceId]

        # using set to avoid the duplication of resources tags requested from the same phone number.
        tags = Set.new(user[:tags])

        new_tags = db_params[:tags]
        new_tags.each do |tag|
          tags << tag
        end

        if user.update(
          first_name: db_params[:firstName],
          last_name: db_params[:lastName],
          tags: Array(tags),
          resources: Array(resources)
          )
          render json: {message:'Welcome Back! Message sent'}, status: 200
        else
          render json: {error: "Bad Request"}, status: 400
        end

       # If this is the first time using the texting service ? we create a new record.
      else
        user = Texting.new(
          first_name: db_params[:firstName],
          last_name: db_params[:lastName],
          phone_number: db_params[:mobilePhone],
          tags: db_params[:tags],
          resources: Array(db_params[:resourceId])
        )

        if user.save
          render json: {message:'Message sent'}, status: 201
        else
          render json: {error: "Bad Request"}, status: 400
        end
      end

    else
      render json: {error: "Bad Request"}, status: 400
    end
  end

  
  private

  # data to send to Textellent.
  def textellent_params
    params.require(:data).permit!.except(:ressourseId)
  end

  # data to save in DB.
  def db_params
    params.require(:data).permit(
      :firstName,
      :lastName, 
      :mobilePhone, 
      :resourceId,
      :tags => []
      )
  end

  # handling the post request to Textellent API.
  def post(data)
    headers = {
      'Content-Type' => 'application/json',
      'authCode' => ENV['TEXTELLENT_AUTH_CODE'],
    }
    options = { 
      headers:  headers,
      body: data.to_json
    }
    response = HTTParty.post("https://client.textellent.com/api/v1/engagement/create.json", options)
  end

end
