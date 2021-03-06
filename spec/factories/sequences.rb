# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name)       { |n| "Example Name #{n}" }
  sequence(:password)   { |n| "examplepassword#{n}" }
  sequence(:email)      { |n| "foo#{n}@trendsettermarketing.net" }
  sequence(:bad_email)  { |n| "foo#{n}@example.com" }
  sequence(:cpm)        { |n| [1,2,3,4,5,6,7,8,9,10].sample * n }

  sequence(:ip_address) { |n|
    i=['71.203.171.81','74.241.171.206','68.98.61.117','212.40.138.14','91.121.68.133','98.228.76.84','94.67.52.141','59.164.8.9','84.194.56.70','99.248.220.250','83.128.52.145','206.240.25.208','65.182.232.227','81.165.166.142','84.71.203.187','62.202.101.196','79.101.157.197','87.82.19.177','86.96.226.87','86.166.174.196','144.36.223.201','72.64.227.149','67.202.54.191','84.197.25.189','119.152.39.236','84.81.62.237','98.243.190.147','203.82.91.104','122.162.176.94','68.5.126.12','196.35.158.178','86.8.107.235','90.202.27.245','80.133.233.136','61.246.47.32','60.234.169.117','86.149.165.8','15.211.169.107','65.33.117.28','124.253.113.141','124.43.214.144','59.95.131.151','75.157.181.46','74.216.62.200','67.112.121.194','81.83.177.68','79.166.91.79','89.201.202.116','203.99.183.45','99.244.157.34','75.156.53.209','74.12.57.153','85.243.58.209','78.174.93.51','93.138.92.149','76.211.23.125','139.80.123.34','122.50.216.114','75.91.74.10','86.67.88.111','24.107.229.161','121.242.205.226','74.14.67.225','79.175.119.42','200.38.31.86','99.242.0.185','92.0.131.175','118.137.227.237','114.4.12.16','98.17.103.35','78.0.239.0','117.198.160.220','91.182.193.222','60.51.104.43','71.238.103.230','83.93.104.72','115.133.87.67','196.35.158.178','121.72.204.218','81.179.22.133','59.95.163.55','121.222.245.206','86.96.227.88','118.137.108.97','89.201.234.117','82.81.108.226','220.244.46.216','86.3.28.215','59.92.64.117','209.195.69.108','82.52.126.200','86.9.149.40','123.237.180.13','24.42.64.118','81.11.242.217','86.172.235.76','59.96.174.103','190.24.120.4','83.88.125.19','203.196.170.112','124.30.150.11','62.120.51.112','90.213.27.244','84.196.254.249','115.64.145.93','41.238.190.113','60.54.121.37','122.106.39.238','122.55.113.159','84.221.32.253','220.255.7.187','59.95.182.52','122.57.80.126','89.180.73.97','98.235.130.4','124.217.77.5','98.235.130.4','86.0.201.96','86.96.227.89','119.152.46.107','122.167.86.182','94.170.20.76','90.195.51.114','121.246.251.140','81.98.21.178','81.98.21.178','202.56.7.151','69.141.62.18','93.139.123.84','115.127.11.50','85.232.219.247','213.196.73.14','85.232.219.247','124.247.220.99','114.143.244.77','119.95.77.244','122.161.90.46','89.181.36.164','94.194.214.211','87.55.198.79','122.53.119.5','122.162.48.89','62.245.125.153','82.47.25.76','62.245.125.153','116.71.25.241','117.192.7.113','84.192.85.166','84.193.160.209','125.238.116.242','81.84.176.163','125.238.68.15','77.18.70.186','119.30.36.53','83.238.216.180','90.191.53.205','62.6.254.229','122.173.155.111','81.180.223.106','60.242.154.200','217.129.219.186','61.6.217.124','222.153.160.61','218.248.46.117','86.91.191.220','24.247.72.153','91.187.101.72','24.247.72.153','79.177.113.44','115.147.96.134','220.244.120.165','80.80.170.125','79.163.34.62','125.236.190.117','121.222.49.231','24.122.94.173','189.12.4.164','89.238.219.130','117.98.136.81','94.210.139.123','68.73.193.249','68.83.4.74','24.210.134.195','121.222.192.212','72.18.113.77','66.142.84.221','99.229.217.50','124.169.210.232','173.25.171.41','98.27.228.159','117.196.228.96','205.211.198.219','124.210.129.110','117.199.118.204','68.124.176.56','68.124.176.56','186.80.149.155','117.192.109.136','122.108.15.225','71.7.126.198','96.233.198.57','122.107.164.180','201.45.188.146','59.93.9.135','76.101.118.10','99.36.131.129','93.96.231.47','155.69.160.46','58.69.57.142','70.26.135.32','74.61.221.7','201.45.188.146','99.8.231.151','85.72.41.83','203.219.211.101','75.67.141.152','189.5.9.57','99.224.171.11','116.71.79.91','75.45.6.109','74.14.9.132']
    i.sample
    # l=i.count - 1
    # while n >= i.count do
    #   n -= l
    # end
    # i[n]
  }
  sequence(:referer)      { |n| "examplerefererurl#{n}.com" }
  sequence(:request_url)  { |n| "examplerequesturl#{n}.com" }
  sequence(:user_agent)   { |n| "example user agent #{n}" }

  sequence(:video_token)  { |n|
    t = [
      'r_Jwx3XKcXU','JjDre7EaHFQ','OR6AV9yJPoM','AMOOkBWr9G4','v0r8zxsWoR4','Z5pWz_OR5Sg','LpKyzSxVhk4','g8gJOCwBuFc','rMqayQ-U74s','tvnGBYMe9gM','OY1vdSw2zhY','iVtV6NWFbGM','HBxt_v0WF6Y','A3MGfJ3eMGA','PQjovLrnvVo','rMqayQ-U74s','Y5fBdpreJiU','LsOo3jzkhYA','mgVwv0ZuPhM','g88sc4wY4ow','LUrUPzLm5SI','9ha5ujHnYXg','Uggz88zl8QQ','cmSbXsFE3l8','d5hvgBD68_s','lExW80sXsHs','SMpL6JKF5Ww','QK8mJJJvaes','KlyXNRrsk4A','uPOUgobWTT0','JF8BRvqGCNs','9A4udiJJzXY','LrUvu1mlWco','Ys7-6_t7OEQ','fDUKt_XgfJ4','KQ6zr6kCPj8','EX1I2LI8Wc8','vNoKguSdy4Y','pTUJmnh7B4Q','kYtGl1dX5qI','f8Q3TDkhZrA','eQWG8BVeryU','FOIjvHjK0Rw','KRaWnd3LJfs','IsUsVbTj2AY','mLTSOUTNH0w','mLTSOUTNH0w','pEz95ql6tlI','uuwfgXD8qV8','9bZkp7q19f0','Pum3DpmbEl4','nPvuNsRccVw','sPhhZg9v9NU','fQrbZzRbD8k','8UVNT4wvIGY','7w8QnRe0nEI','NKDXuCE7LeQ','k0BWlvnBmIE','2zNSgSzhBfM','ToPh26T6bgk','mIQToVqDMb8','Rgox84KE7iY','KmxaY_OVvWA','ghOsK2582zM','dxytyRy-O1k','NicMZ589snY','7470G2NYpxs','fnKNz7FxmPc','lSi6W29MxGs','AgFeZr5ptV8','GDY5GSb_-TA','zsmUOdmm02A','unRldLdllZ8','WU7SGn0MeP0','na_l3zUirRo','ndhDDbgriB8','g8MfmzFf-F0','W9pwmD8J8yg','B9rSBcoX9ak','jGwfa1CF5Yo','g3GhDWMb_3E','lSCUKqVqs7I',
      'fWNaR-rxAic'
    ][n]
    # puts t
    t
  }


end
