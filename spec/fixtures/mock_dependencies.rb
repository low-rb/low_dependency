# frozen_string_literal: true

require_relative '../../lib/low_dependency'

# Single.

class IncludeDependency
  include LowDependency[:provider_one]
end

class IncludeStringDependency
  include LowDependency['provider_one']
end

class IncludeNamespacedStringDependency
  include LowDependency['namespace.provider_one']
end

class IncludeDependencyWithProvider
  include LowDependency[dependency_one: :provider_one]
end

class IncludeDependencyWithStringProvider
  include LowDependency[dependency_one: 'provider_one']
end

class IncludeDependencyWithNamespacedStringProvider
  include LowDependency[dependency_one: 'namespace.provider_one']
end

# Multiple.

class IncludeDependencies
  include LowDependency[:provider_one, :provider_two]
end

class IncludeStringDependencies
  include LowDependency['provider_one', 'provider_two']
end

class IncludeNamespacedStringDependencies
  include LowDependency['namespace.provider_one', 'namespace.provider_two']
end

class IncludeDependenciesWithProviders
  include LowDependency[dependency_one: :provider_one, dependency_two: :provider_two]
end

class IncludeDependenciesWithStringProviders
  include LowDependency[dependency_one: 'provider_one', dependency_two: 'provider_two']
end

class IncludeDependenciesWithNamespacedStringProviders
  include LowDependency[dependency_one: 'namespace.provider_one', dependency_two: 'namespace.provider_two']
end
