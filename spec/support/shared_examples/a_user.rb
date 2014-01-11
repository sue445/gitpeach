shared_examples_for :a_user do
  it{ expect(user.gitlab_user_id).not_to be_nil }
  it{ expect(user.username).not_to       be_blank }
  it{ expect(user.private_token).not_to  be_blank }
end
