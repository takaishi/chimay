class Time
  # Hack mruby-aws-s3's Time#rfc2822
  # localtimeの場合時刻がずれてしまうので強制的にUTCにする
  def rfc2822
    utcdate = getutc
    sprintf('%s, %02d %s %0*d %02d:%02d:%02d ',
      RFC2822_DAY_NAME[utcdate.wday],
      utcdate.day, RFC2822_MONTH_NAME[utcdate.mon-1], utcdate.year < 0 ? 5 : 4, utcdate.year,
      utcdate.hour, utcdate.min, utcdate.sec) +
    if utcdate.utc?
      '-0000'
    else
      off = utc_offset
      sign = off < 0 ? '-' : '+'
      sprintf('%s%02d%02d', sign, (off.abs / 60) / 60, (off.abs / 60) % 60)
    end
  end
end
