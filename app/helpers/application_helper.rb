module ApplicationHelper
  
  def bootstrap_class_for flash_type
     { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym]
  end
  
  def flash_messages(opts = {})
     flash.each do |msg_type, message|
       concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
               concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                 concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
                 concat content_tag(:span, 'Close', class: 'sr-only')
               end)
               concat message
             end)
     end
     nil
  end
  
  def bootstrap_radio_buttons(form_object:,method:,options_for_radio:)
    # options_for_radio is array of hashes - [{name: 'name',value: 'value'},{name..]
    html = '<div class="btn-group" data-toggle="buttons">'
    options_for_radio.each do |option|
        html += '<label class="btn btn-primary'
        current_value = form_object.object.send(method)
        if form_object.object.column_for_attribute(method).type == :boolean
          if (option[:value] == "0" && current_value == false) || (option[:value] == "1" && current_value == true)
            is_active = true
          else
            is_active = false
          end
        else
          is_active = (form_object.object.send(method) == option[:value])
        end
        if is_active
          html += ' active'
        end
        html += '"> '
        html += option[:name]
        html += (form_object.radio_button method,option[:value],id: "#{method}_#{option[:value]}")
        html += '</label>'
    end
    html += "</div>"
    return html
  end
end
