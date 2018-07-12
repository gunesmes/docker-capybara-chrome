class Members
   def initialize
      @member_list = {}

      @member_list["John Doe"] = {
         :email => 'maidanjohndoe@gmail.com',
         :password => 'Pas12345!@',
         :name => 'John Doe'
      }      

      # add new users like below
      @member_list["Jane Doe"] = {
         :email => 'maidanjohndoe1@gmail.com',
         :password => 'Pas12345!@',
         :name => 'Jane',
         :lastname => "Doe"
      }

   end

   def get(name)
      @member_list[name]
   end
end
