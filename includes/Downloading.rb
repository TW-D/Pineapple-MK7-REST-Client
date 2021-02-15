module Downloading

    protected def download(method, uri, payload, destination)
        
        # Payload debug 
        # puts(payload.to_json())

        begin

            response = Request.execute(
                method: method,
                url: PineappleMK7::System::URL + uri,
                timeout: 30,
                payload: payload.to_json(),
                headers: {
                    content_type: :json,
                    'Authorization' => "Bearer " + PineappleMK7::System::BEARER 
                },
                raw_response: true
            )

            file = response.file()

        rescue Exception => e

            # Body debug
            # pp(e.http_body())
            abort("#{method} #{payload.join()} request has failed")
            
        else

            if (file.size() > 0)

                FileUtils.cp(file.path(), destination)
                @path = destination + File.basename(file.path())

            else
                
                # Body debug
                # pp(body)
                abort("#{method} #{payload.join()} does not return a correct value")
                
            end

        end

    end

end