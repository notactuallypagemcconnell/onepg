FROM ruby:2.5-stretch
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get install -yyq esl-erlang elixir
RUN mix local.hex --force
RUN mix local.rebar --force
COPY make_the_page/ /app
RUN cd app && bundle && cd elixir_onepg && mix do deps.get, compile, escript.build
