class PublicationModelGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, type: :string, default: :article

  def generate
    create_model
    create_controller
    create_migration
    print_routing_instruction
  end

  private

  def create_model
    locals = {
      model_class_name: model_name.classify
    }

    template(
      'publication_model.erb',
      "app/models/#{model_name.downcase}.rb",
      locals
    )
  end

  def create_controller
    locals = {
      controller_class_name: model_name.classify.pluralize
    }

    template(
      'publication_controller.erb',
      "app/controllers/#{model_name.downcase.pluralize}_controller.rb",
      locals
    )
  end

  def create_migration
    ts = Time.now.strftime("%Y%m%d%H%M%S")

    locals = {
      migration_class_name: model_name.tableize.classify,
      migration_table_name: model_name.tableize
    }

    template(
      'publication_migration.erb',
      "db/migrate/#{ts}_create_#{model_name.downcase.tableize}_publication_model.rb",
      locals
    )
  end

  def print_routing_instruction
    puts "
      You have to add/remove the following routes".yellow

    puts """
      ThePublication::Routes.mixin(self, '#{model_name}')
    """.red
  end
end
