module Authentication

    public def login()

        begin

            url = "http://" + @host + ":" + @port + "/api/"

            response = Request.execute(
                method: :post,
                url: url + "login",
                timeout: 10,
                payload: {
                    'username' => "root",
                    'password' => @password
                }.to_json(),
                headers: { 
                    content_type: :json, 
                    accept: :json 
                }
            )

            body = response.body()

        rescue
            abort("login request has failed")
        else

            if (body.include?('{"token":"'))

                self.class().const_set(:URL, url)
                self.class().const_set(:BEARER, JSON.parse(body)['token'])
                self.class().const_set(:MAC, @mac)

                return(true)
            
            else

                return(false)

            end

        end

    end

end