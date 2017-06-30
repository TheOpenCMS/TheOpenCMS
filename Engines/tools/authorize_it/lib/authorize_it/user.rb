module AuthorizeIt::User
  include ::AuthorizeIt::ACLPermits::User
  include ::AuthorizeIt::Ownership::User
end
