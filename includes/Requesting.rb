module Requesting

    protected def request(method, uri, payload, confirm)

        # Payload debug 
        # puts(payload.to_json())

        begin

            response = Request.execute(
                method: method,
                url: PineappleMK7::System::URL + uri,
                timeout: 20,
                payload: payload.to_json(),
                headers: { 
                    content_type: :json, 
                    accept: :json,
                    'Authorization' => "Bearer " + PineappleMK7::System::BEARER 
                }
            )

            body = response.body()

        rescue Exception => e

            # Body debug
            # pp(e.http_body())
            abort("#{method} #{uri} request has failed")
            
        else

            if (body.include?(confirm))

                @body = JSON.parse(body, object_class: OpenStruct)

            else
                
                # Body debug
                # pp(body)
                abort("#{method} #{uri} does not return a correct value")
                
            end

        end
        
    end

end