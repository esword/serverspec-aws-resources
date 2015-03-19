require 'aws-sdk'
require 'serverspec'
require_relative 'security_group_mixin'

module Serverspec
  module Type

    class LaunchConfiguration < Base
      include SecurityGroups

      def initialize(name)
        @name = name
      end

      def content
        asg = AWS::AutoScaling.new
        asg.launch_configurations[@name]
      end

      def has_image_id?(image_id)
        content.image_id == image_id
      end

      def has_instance_type?(instance_type)
        content.instance_type == instance_type
      end

      def has_key_name?(key_name)
        content.key_name == key_name
      end

      def has_user_data?(user_data)
        content.user_data == user_data
      end

      def has_security_groups?(user_data)
        content.user_data == user_data
      end

      def to_s
        "launch configuration: #{@name}"
      end

    end

    #this is how the resource is called out in a spec
    def launch_configuration(name)
      LaunchConfiguration.new(name)
    end

  end
end

include Serverspec::Type