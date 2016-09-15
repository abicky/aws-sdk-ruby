# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing for info on making contributions:
# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws
  module RDS
    class DBClusterParameterGroup

      extend Aws::Deprecations

      # @overload def initialize(name, options = {})
      #   @param [String] name
      #   @option options [Client] :client
      # @overload def initialize(options = {})
      #   @option options [required, String] :name
      #   @option options [Client] :client
      def initialize(*args)
        options = Hash === args.last ? args.pop.dup : {}
        @name = extract_name(args, options)
        @data = options.delete(:data)
        @client = options.delete(:client) || Client.new(options)
      end

      # @!group Read-Only Attributes

      # @return [String]
      def name
        @name
      end
      alias :db_cluster_parameter_group_name :name

      # Provides the name of the DB parameter group family that this DB
      # cluster parameter group is compatible with.
      # @return [String]
      def db_parameter_group_family
        data.db_parameter_group_family
      end

      # Provides the customer-specified description for this DB cluster
      # parameter group.
      # @return [String]
      def description
        data.description
      end

      # The Amazon Resource Name (ARN) for the DB cluster parameter group.
      # @return [String]
      def db_cluster_parameter_group_arn
        data.db_cluster_parameter_group_arn
      end

      # @!endgroup

      # @return [Client]
      def client
        @client
      end

      # Loads, or reloads {#data} for the current {DBClusterParameterGroup}.
      # Returns `self` making it possible to chain methods.
      #
      #     db_cluster_parameter_group.reload.data
      #
      # @return [self]
      def load
        resp = @client.describe_db_cluster_parameter_groups(db_cluster_parameter_group_name: @name)
        @data = resp.dbclusterparametergroups[0]
        self
      end
      alias :reload :load

      # @return [Types::DBClusterParameterGroup]
      #   Returns the data for this {DBClusterParameterGroup}. Calls
      #   {Client#describe_db_cluster_parameter_groups} if {#data_loaded?} is `false`.
      def data
        load unless @data
        @data
      end

      # @return [Boolean]
      #   Returns `true` if this resource is loaded.  Accessing attributes or
      #   {#data} on an unloaded resource will trigger a call to {#load}.
      def data_loaded?
        !!@data
      end

      # @!group Actions

      # @param [Hash] options ({})
      # @option options [required, String] :db_parameter_group_family
      #   The DB cluster parameter group family name. A DB cluster parameter
      #   group can be associated with one and only one DB cluster parameter
      #   group family, and can be applied only to a DB cluster running a
      #   database engine and engine version compatible with that DB cluster
      #   parameter group family.
      # @option options [required, String] :description
      #   The description for the DB cluster parameter group.
      # @option options [Array<Types::Tag>] :tags
      #   A list of tags.
      # @return [DBClusterParameterGroup]
      def create(options = {})
        options = options.merge(db_cluster_parameter_group_name: @name)
        resp = @client.create_db_cluster_parameter_group(options)
        DBClusterParameterGroup.new(
          name: resp.data.db_cluster_parameter_group.db_cluster_parameter_group_name,
          data: resp.data.db_cluster_parameter_group,
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @return [EmptyStructure]
      def delete(options = {})
        options = options.merge(db_cluster_parameter_group_name: @name)
        resp = @client.delete_db_cluster_parameter_group(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, Array<Types::Parameter>] :parameters
      #   A list of parameters in the DB cluster parameter group to modify.
      # @return [DBClusterParameterGroup]
      def modify(options = {})
        options = options.merge(db_cluster_parameter_group_name: @name)
        resp = @client.modify_db_cluster_parameter_group(options)
        DBClusterParameterGroup.new(
          name: resp.data.db_cluster_parameter_group_name,
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @option options [Boolean] :reset_all_parameters
      #   A value that is set to `true` to reset all parameters in the DB
      #   cluster parameter group to their default values, and `false`
      #   otherwise. You cannot use this parameter if there is a list of
      #   parameter names specified for the `Parameters` parameter.
      # @option options [Array<Types::Parameter>] :parameters
      #   A list of parameter names in the DB cluster parameter group to reset
      #   to the default values. You cannot use this parameter if the
      #   `ResetAllParameters` parameter is set to `true`.
      # @return [DBClusterParameterGroup]
      def reset(options = {})
        options = options.merge(db_cluster_parameter_group_name: @name)
        resp = @client.reset_db_cluster_parameter_group(options)
        DBClusterParameterGroup.new(
          name: resp.data.db_cluster_parameter_group_name,
          client: @client
        )
      end

      # @deprecated
      # @api private
      def identifiers
        { name: @name }
      end
      deprecated(:identifiers)

      private

      def extract_name(args, options)
        value = args[0] || options.delete(:name)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :name"
        else
          msg = "expected :name to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      class Collection

        include Aws::Resources::Collection

        # @return [Enumerator<DBClusterParameterGroup>]
        def each(&block)
          enum = super
          enum.each(&block) if block
          enum
        end

      end
    end
  end
end