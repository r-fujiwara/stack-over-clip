# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

require 'erb'

def import_yaml(path)
  yaml = YAML.load(ERB.new(File.read path).result)

  yaml['models'].each do |resource_key, resources|
    klass = resource_key.classify.constantize

    resources.each do |resource_id, attrs|
      primary_key = klass.primary_key
      if resource_id !~ /ignore/
        next if klass.exists?(primary_key => resource_id)
        attrs = attrs.merge(primary_key => resource_id)
      end
      resource = klass.new attrs
      resource.save!
      puts "attrs...#{attrs}"
      resource.update_attributes!(attrs)
    end

    puts "Inserted #{klass} data."
  end
end

import_yaml(Rails.root.join('db', "#{Rails.env}_data.yml"))
