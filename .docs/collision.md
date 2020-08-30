# 1. Basic information
 - Godot documentation: https://docs.godotengine.org/en/3.1/tutorials/physics/physics_introduction.html
 - Godot's collision-shapes have to always use a scale of (1, 1)
 - Physic related values like position, linear_velocity, etc might be inaccurate when accessed outside of Node._physics_process()
 - Node._physics_process() if called 60 times a second by default. (This can be changed and might be something to consider.)

# 1.1 Collision layers
| Layer:   | Name:      | Object Type: | Description:                                                        |
| -------- | ---------- | ------------ | ------------------------------------------------------------------- |
| Layer  1 | World      | StaticBody2D | All static objects that belong to the world                         |
| Layer  2 | Meteoroids | RigidBody2D  | Objects in space fully controlled by physics -> Meteors, Space-junk |
| Layer  3 | Spaceship  | RigidBody2D  | Ships and projectiles that       belong to the player               |
| Layer  4 | Items      | RigidBody2D  | Well Items :)                                                       |
| Layer  5 | Particles  | ???          | Awesome particles                                                   |

## Collision Matrix:

Does X collide with Y
| X \ Y | 1   | 2   | 3   | 4   | 5   | Note                                                                                                            |
| ----- | --- | --- | --- | --- | --- | --------------------------------------------------------------------------------------------------------------- |
| 1     |     |     |     |     |     | The world is static and doesn't have to collide with anything                                                   |
| 2     | X   | X   | X   |     |     | Projectiles should of course not collide the ship they were fired from                                          |
| 3     | X   | X   | X   |     |     |                                                                                                                 |
| 4     | X   | X   | X   | X   |     | Items should pretty much collide with anything, note that characters should probably pick them up on collision. |
| 5     | X   | X   | X   |     |     | Particles are should never effect any objects, since they are purely visual effects                                                                                                                |