module BotTemplates
  def generic_template_with_elements(elements)
    message.reply(
      attachment: {
          type: 'template',
          payload: {
            template_type:"generic",
            sharable: true,
            elements: elements
        }
      }
    )
  end
end
