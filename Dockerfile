FROM ruby
ADD ./ /app
WORKDIR /app
# 使用国内中科大镜像源加快apt速度
COPY ./sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --allow-remove-essential libncursesw5 libslang2 libtinfo5 libcaca0 libavdevice57 ffmpeg 
RUN apt-get install -y ttf-wqy-microhei cron
# 使用国内Gem镜像
RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
RUN bundle install
# 定时任务
RUN crontab cron-sorry
CMD cron && ruby src/sorry.rb
