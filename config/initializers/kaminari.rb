# Avoid conflicts with will_paginate and Active Admin
# See: http://www.activeadmin.info/docs/0-installation.html#will_paginate_compatibility
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end


