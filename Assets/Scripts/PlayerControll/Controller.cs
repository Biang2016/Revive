using UnityEngine;

public class Controller : MonoBehaviour
{
    public float MoveSpeed = 3.0f;
    public float JumpPower = 5f;
    public float Gravity = 9.81f;
    private float default_MoveSpeed = 3.0f;
    private float default_JumpPower = 5f;
    private float default_Gravity = 9.81f;

    public CharacterController MyController;
    public MouseLooker MyMouseLooker;

    private Vector3 velocity = Vector3.zero;

    void Awake()
    {
        default_MoveSpeed = MoveSpeed;
        default_JumpPower = JumpPower;
        default_Gravity = Gravity;
    }

    void Update()
    {
        velocity.x = Input.GetAxis("Horizontal") * MoveSpeed;
        velocity.z = Input.GetAxis("Vertical") * MoveSpeed;

        if (SuperManMode)
        {
            velocity.y = Input.GetAxis("Jump") * MoveSpeed;
        }
        else
        {
            if (MyController.isGrounded)
            {
                if (AllowJump)
                {
                    if (Input.GetKeyDown(KeyCode.Space))
                    {
                        velocity.y = 0;
                        velocity.y += JumpPower * MoveSpeed;
                    }
                }
            }
            else
            {
                velocity.y -= Gravity;
            }
        }

        velocity = transform.TransformDirection(velocity);
        MyController.Move(velocity * Time.deltaTime);
    }

    [SerializeField]private bool superManMode = false;

    public bool SuperManMode
    {
        get { return superManMode; }
        set
        {
            superManMode = value;
            if (value)
            {
                MoveSpeed = GameManager.Instance.SupermanSpeed;
                Gravity = 0;
            }
            else
            {
                MoveSpeed = default_MoveSpeed;
                JumpPower = default_JumpPower;
                Gravity = default_Gravity;
            }
        }
    }

    public bool AllowJump = false;

    public void SetAllowJump()
    {
        AllowJump = true;
    }

    public float ControllerRadiusOnLand = 0.82f;
    public float ControllerRadiusOnRaft = 0.1f;

    public void SetColliderRadiusOnRaft()
    {
        MyController.radius = ControllerRadiusOnRaft;
    }

    public void SetColliderRadiusOnLand()
    {
        MyController.radius = ControllerRadiusOnLand;
    }
}