class CustomHelpers < Middleman::Extension
  helpers do
  end

end

::Middleman::Extensions.register(:custom_helpers, CustomHelpers)
