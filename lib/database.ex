use Amnesia

defdatabase Database do
	deftable Topic, [{:id, autoincrement}, :url, :state, :sharings], type: :ordered_set
end
