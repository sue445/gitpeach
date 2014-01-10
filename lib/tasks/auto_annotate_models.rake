# via. https://github.com/ctran/annotate_models/wiki

if(Rails.env.development?)
  task :set_annotation_options do
    Annotate.set_defaults(
        exclude_tests:     true,
        exclude_fixtures:  true,
        exclude_factories: true,
        show_indexes:      true,
    )
  end

  # Comes with the current master when running `rails g annotate:install`
  # But somehow won't annotate my models correctly (only one)
  # Thus commented out
  # Annotate.load_tasks

  # Annotate models
  task :annotate do
    puts 'Annotating models...'
    system 'bundle exec annotate'
  end

  # Run annotate task after db:migrate
  #  and db:rollback tasks
  Rake::Task['db:migrate'].enhance do
    Rake::Task['annotate'].invoke
  end

  Rake::Task['db:rollback'].enhance do
    Rake::Task['annotate'].invoke
  end
end
