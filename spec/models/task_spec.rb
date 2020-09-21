require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is valid with all attributes' do
    user = User.new(
      email: "sample@sample.com",
      password: "hogehoge",
    )

    task = Task.new(
      title: "sample",
      content: "hogehoge",
      status: 0,
      user: user,
    )
    expect(task).to be_valid
  end

  it 'is invalid without title' do
    task = Task.new(title: nil)
    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without status' do
    task = Task.new(status: nil)
    task.valid?
    expect(task.errors[:status]).to include("can't be blank")
  end

  it 'is invalid with a duplicate title' do
    user = User.new(
      email: "sample@sample.com",
      password: "hogehoge",
    )

    Task.create(
      title: "sample",
      content: "hogehoge",
      status: 0,
      user: user
    )
    task = Task.new(
      title: "sample",
      content: "foobar",
      status: 0,
      user: user
    )
    task.valid?
    expect(task.errors[:title]).to include("has already been taken")
  end

  it 'is valid with another title' do
    user = User.new(
      email: "sample@sample.com",
      password: "hogehoge",
    )

    Task.create(
      title: "sample",
      content: "hogehoge",
      status: 0,
      user: user,
    )
    task = Task.new(
      title: "sample01",
      content: "foobar",
      status: 0,
      user: user,
    )
    expect(task).to be_valid
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
