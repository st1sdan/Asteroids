extends CharacterBody2D

@export_category("Moving vars")
@export var speed : int = 1
@export var deceleration : int = 1
@export var max_speed : int = 100
var rotation_direction
var rotation_speed = PI/1.5
var is_moving
var max_speed_vector = Vector2(max_speed, max_speed)

@export_category("Bullet vars")
const BULLET_PATH = preload("res://Scenes/bullet.tscn")
var can_shoot : bool
@export var bullet_speed : int = 100 # Скорость пули
@export var bullet_timer : int = 20 # Как часто можно стрелять

var screen_size = Vector2(480, 320)

## Функция, обновляемая каждый кадр
func _physics_process(delta):
    move(delta)
    shoot()
    out_of_bounds()
    move_and_slide()


## Функция для движения
func move(delta):
    # Задаем направление поворота персонажа
    rotation_direction = Input.get_axis("ui_left", "ui_right")
    # Проверяем нажата ли клавиша для движения вперед
    is_moving = Input.is_action_pressed("forward")

    # Поворот персонажа при нажатии клавиш
    if rotation_direction > 0:
        rotation += rotation_speed * delta
    elif rotation_direction < 0:
        rotation -= rotation_speed * delta

    # Если клавиша вперед нажата двигаемся вперед относительно поворота персонажа
    # И замедляемся, при отжатии клавиши
    if is_moving:
        velocity += Vector2(0, 1).rotated(rotation) * speed
    else:
        velocity = velocity.move_toward(Vector2.ZERO, deceleration)
    velocity = velocity.clamp(-max_speed_vector, max_speed_vector)


## Перемещение персонажа при достижении края экрана
func out_of_bounds():
    position = position.posmodv(screen_size)


## Стрельба при нажатии клавиши и отсчет до возможности следующего выстрела
func shoot():
    bullet_timer -= 1

    if !can_shoot and bullet_timer <= 0:
        can_shoot = true
        bullet_timer = 20

    if can_shoot and Input.is_action_just_pressed("shoot"):
        can_shoot = false
        var bullet = BULLET_PATH.instantiate()
        bullet.scale = Vector2(0.1, 0.1)

        get_parent().add_child(bullet)
        bullet.position = $Marker2D.global_position
        bullet.velocity = Vector2(0, 1).rotated(rotation) * bullet_speed


## Функция для события при нажатии определенной кнопки
func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.keycode == KEY_ESCAPE:
            get_tree().quit()
        if event.pressed and event.keycode == KEY_R:
            position = get_viewport_rect().size/2
