module GoogleAnalytics
  autoload :Client,  'google_analytics/client'
  autoload :User,    'google_analytics/user'
  autoload :Account, 'google_analytics/account'
  autoload :Profile, 'google_analytics/profile'
  autoload :Report, 'google_analytics/report'
  
  DXP_NAMESPACE = 'http://schemas.google.com/analytics/2009'
end