FactoryGirl.define do
  def rand_str
    # via. http://d.hatena.ne.jp/JunMitani/20080214
    a = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    Array.new(10){a[rand(a.size)]}.join
  end

  sequence(:random_int) { rand(1 .. 100000) }
  sequence(:random_flag){ rand(10) < 5 }
  sequence(:random_str) { rand_str }
  sequence(:random_url) { "http://"+ rand_str }
  sequence(:random_mail){ "#{rand_str}@#{rand_str}.com" }

  sequence(:random_path) { rand_str + "/" + rand_str }

  sequence(:random_time){
    diff_day = 150 - rand(365)
    Time.now + diff_day
  }
end

