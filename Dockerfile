FROM ubuntu:16.04
RUN apt update && apt-get install inotify-tools gnupg2 wget -y
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update -yyq
RUN apt-get install -yyq esl-erlang elixir
RUN mix local.hex --force
RUN mix local.rebar --force
RUN apt-get install -yyq ruby-full
RUN gem install bundler
COPY . /app
RUN cd app && bundle && cd elixir_onepg && mix do deps.get, compile, escript.build
