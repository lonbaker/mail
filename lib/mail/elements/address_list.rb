module Mail
  class AddressList
    def initialize(string)
      @address_nodes = Mail::AddressListsParser.new.parse(string).addresses
    end
    
    def address_nodes
      @address_nodes
    end
    
    def addresses
      @addresses ||= get_addresses.map do |address_tree|
        Mail::Address.new(address_tree)
      end
    end
    
    def get_addresses
      (individual_recipients + group_recipients.map { |g| g.group_list.addresses }).flatten
    end
    
    def group_recipients
      @group_recipients ||= @address_nodes.select { |an| an.respond_to?(:group_name) }
    end
    
    def individual_recipients
      @individual_recipients ||= @address_nodes - group_recipients
    end
    
    def group_names
      group_recipients.map { |g| g.group_name.text_value }
    end
  end
end