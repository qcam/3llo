# frozen_string_literal: true

require 'container'

$container = Container.new
$container.register(:user, {})
$container.register(:board, {})
