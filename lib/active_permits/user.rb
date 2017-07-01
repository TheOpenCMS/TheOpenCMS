module ActivePermits::User
  include ::ActivePermits::ACLPermits::User
  include ::ActivePermits::Ownership::User
end
