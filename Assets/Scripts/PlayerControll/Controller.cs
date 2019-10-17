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

    private float v_y = 0;
    private Vector3 velocity = Vector3.zero;

    void Start()
    {
        default_MoveSpeed = MoveSpeed;
        default_JumpPower = JumpPower;
        default_Gravity = Gravity;
    }

    void Update()
    {
        if (Input.GetKeyUp(KeyCode.P))
        {
            SupermanMode = !SupermanMode;
        }

        if (SupermanMode)
        {
            MoveSpeed = 20f;
            Gravity = 0;
        }
        else
        {
            MoveSpeed = default_MoveSpeed;
            JumpPower = default_JumpPower;
            Gravity = default_Gravity;
        }

        velocity.x = Input.GetAxis("Horizontal") * MoveSpeed;
        velocity.z = Input.GetAxis("Vertical") * MoveSpeed;

        if (SupermanMode)
        {
            velocity.y = Input.GetAxis("Jump") * MoveSpeed;
        }
        else
        {
            if (MyController.isGrounded)
            {
                if (AllowJump)
                {
                    v_y = 0;
                    velocity.y = 0;
                    if (Input.GetKeyDown(KeyCode.Space))
                    {
                        velocity.y += JumpPower * MoveSpeed;
                    }
                }
            }
            else //在空中时
            {
                v_y -= Gravity * Time.deltaTime;
                velocity.y += v_y;
            }
        }

        velocity = transform.TransformDirection(velocity);
        MyController.Move(velocity * Time.deltaTime);
    }

    public bool AllowJump = false;

    public void SetAllowJump()
    {
        AllowJump = true;
        MyController.radius = 0.82f;
    }

    public bool SupermanMode;
    public float SupermanSpeed = 20f;
}