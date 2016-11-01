host 'caixadacegonha.com.br'

# Basic sitemap – you can change the name :site as you wish
sitemap :site do
  url root_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
end

# Pings search engines after generation has finished
ping_with "http://#{host}/sitemap.xml"
