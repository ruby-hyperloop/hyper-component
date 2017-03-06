require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'React Integration', js: true do
  it "The hyper-component gem can use Hyperloop::Component to create components" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        render(DIV) { 'hello'}
      end
    end
    pause
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to be_nil
  end
  it "The hyper-component gem can use Hyperloop::Component::Mixin to create components" do
    mount "TestComp" do
      class TestComp
        include Hyperloop::Component::Mixin
        render(DIV) { 'hello'}
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to be_nil
  end
  it "The hyper-component gem can use the deprecated React::Component::Base class to create components" do
    mount "TestComp" do
      class TestComp < React::Component::Base
        render(DIV) { 'hello'}
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to eq(
    ["Warning: Deprecated feature used in TestComp. The class name React::Component::Base has been deprecated.  Use Hyperloop::Component instead."]
    )
  end
  it "The hyper-component gem can use Hyperloop::Component::Mixin to create components" do
    mount "TestComp" do
      class TestComp
        include React::Component
        render(DIV) { 'hello'}
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to eq(
    ["Warning: Deprecated feature used in TestComp. The module name React::Component has been deprecated.  Use Hyperloop::Component::Mixin instead."]
    )
  end
  it "The hyper-component gem can use hyper-store state syntax" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        before_mount do
          mutate.foo 'hello'
        end
        render(DIV) do
          state.foo
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to be_nil
  end
  it "and it can still use the deprecated mutate syntax" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        before_mount do
          state.foo! 'hello'
        end
        render(DIV) do
          state.foo
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to eq(
    ["Warning: Deprecated feature used in TestComp. The mutator 'state.foo!' has been deprecated.  Use 'mutate.foo' instead."]
    )
  end
  it "can use the hyper-store syntax to declare component states" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        state foo: 'hello'
        render(DIV) do
          " foo = #{state.foo}"
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to be_nil
  end
  it "can use the hyper-store syntax to declare component states and use deprecated mutate syntax" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        state foo: true
        after_mount do
          state.foo! 'hello' if state.foo
        end
        render(DIV) do
          state.foo
        end
      end
    end
    expect(page).to have_content('hello')
  end
  it "can still use the deprecated syntax to declare component states" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        define_state foo: 'hello'
        render(DIV) do
          state.foo
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to eq(
    ["Warning: Deprecated feature used in TestComp. 'define_state' is deprecated. Use the 'state' macro to declare states."]
    )
  end
  it "can use the hyper-store syntax to declare class states" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        state foo: 'hello', scope: :class, reader: true
        render(DIV) do
          TestComp.foo
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to be_nil
  end
  it "can still use the deprecated syntax to declare component states" do
    mount "TestComp" do
      class TestComp < Hyperloop::Component
        export_state foo: 'hello'
        render(DIV) do
          TestComp.foo
        end
      end
    end
    expect(page).to have_content('hello')
    expect_evaluate_ruby("React::Component.instance_variable_get('@deprecation_messages')").to eq(
    ["Warning: Deprecated feature used in TestComp. 'export_state' is deprecated. Use the 'state' macro to declare states."]
    )
  end

  it 'defines component spec methods' do
    mount "Foo" do
      class Foo
        include React::Component
        def render
          "initial_state = #{initial_state}"
        end
      end
    end
    expect(page).to have_content('initial_state = ')
  end

  it 'allows block for life cycle callback' do
    mount "Foo" do
      class Foo < React::Component::Base
        before_mount do
          set_state({ foo: "bar" })
        end
        render(DIV) do
          state[:foo]
        end
      end
    end
    expect(page).to have_content('bar')
  end

  it 'allows kernal method names like "format" to be used as state variable names' do
    mount 'Foo' do
      class Foo < React::Component::Base
        before_mount do
          mutate.format 'hello'
        end
        render(DIV) do
          state.format
        end
      end
    end
    expect(page).to have_content('hello')
  end
end
