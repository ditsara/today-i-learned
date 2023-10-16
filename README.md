# Today I Learned

A Rails 7 demo app.

## Functional Goals

Build a Twitter-like social messageboard system for internal company use. Users
can create posts about what they have learned recently. Other users can
interact with posts by replying or reacting. All users must be logged in and
authorized to view all information.

## Technical Goals

Demonstrate Rails 7 features that speed the development of common business
applications. These include:

* ActiveStorage
* Turbo and Stimulus
* ActionCable (WebSockets)
* Various libraries to speed development of common functionality

## Libraries

[Sorcery](https://github.com/sorcery/sorcery) for authentication. This is
actually not the most popular Rails auth library (that honor belongs to
Devise), but I prefer Sorcery's more explicit approach. It's slightly slower to
implement, but makes it easier to support different and non-standard business
use cases.

[Slim](https://slim-template.github.io) for HTML templating. There's nothing
wrong with the default, Embedded Ruby or "ERB", but I prefer Slim's cleaner and
more minimalist syntax. Otherwise, writing HTML typically relies a lot of
editor tooling which is sometimes not so reliable.

[Ancestry](https://github.com/stefankroes/ancestry) implements a tree using the
materialized path model. This is much more efficient than recursing through
`parent_id` in your database. Social content is essentially tree content --
think replies-to-replies.

[Kaminari](https://github.com/kaminari/kaminari) for pagination. Provides
configurable pagination functions and some view helpers.
