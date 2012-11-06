module ActiveRecord
  class Base
    def Base.define_constants_for_attribute(attribute, *constants)
      attribute = attribute.to_s

      constants.each do |const|
        const = const.to_s

        const_name = "#{attribute.upcase}_#{const.upcase}"
        self.const_set(const_name, const)

        define_method("#{const}?") do
          self.class.const_get(const_name) == self.send(attribute)
        end

        define_method("#{const}!") do
          self.send("update_attribute", attribute, self.class.const_get(const_name))
        end
      end
    end
  end
end
