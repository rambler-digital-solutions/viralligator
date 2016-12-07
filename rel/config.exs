use Mix.Releases.Config,
    default_release: :default,
    default_environment: :dev

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"I6&Q(;0B?::7{Mx[!m2}b:0_ZYWubeTE/ymkNUX+xvQ+!bKDgZ)GaOAC[O~UFmt^"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"I6&Q(;0B?::7{Mx[!m2}b:0_ZYWubeTE/ymkNUX+xvQ+!bKDgZ)GaOAC[O~UFmt^"
end

release :viralligator do
  set version: current_version(:viralligator)
end
