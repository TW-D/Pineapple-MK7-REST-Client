module Notifications_Actions

    public def clearAll()
        self.request(
            'DELETE',
            'notifications',
            {},
            '{"success":true}'
        )
    end

end