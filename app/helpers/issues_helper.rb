module IssuesHelper
  # via.
  # * https://github.com/gitlabhq/gitlabhq/blob/master/lib/gitlab/issues_labels.rb
  # * https://github.com/gitlabhq/gitlabhq/blob/master/app/helpers/labels_helper.rb
  def label_css_class(name)
    warning_labels   = %w(documentation support)
    neutral_labels   = %w(discussion suggestion)
    positive_labels  = %w(feature enhancement)
    important_labels = %w(bug critical confirmed)

    case name
    when *warning_labels
      'label-warning'
    when *neutral_labels
      'label-primary'
    when *positive_labels
      'label-success'
    when *important_labels
      'label-danger'
    else
      'label-info'
    end
  end
end
