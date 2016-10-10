use Amnesia

defdatabase Database do
	deftable Topic, [:id, :url, :state, :sharings], type: :ordered_set
end
