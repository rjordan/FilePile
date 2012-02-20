module ApplicationHelper

  def bootstrap_button_link(text, location, options={})
    options[:class] ||= []
    options[:class] << 'btn'
    options[:class] << 'btn-primary' if options[:primary]
    if(options[:icon])
      icons = []
      icons << "icon-#{options[:icon]}"
      icons << "icon-white" if options[:primary]
      icon = "<i class=\"#{icons.join(' ')}\"></i>"
    end
    options.reject! { |k,v| [:primary, :icon].include?(k) }
    link_to "#{text} #{icon}".html_safe,
            location,
            options
  end

end
