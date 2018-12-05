using UnityEngine;


public class Main : MonoBehaviour
{
    void Awake()
    {
        //这两个要在最前面且顺序不能乱
        gameObject.AddComponent<EventMgr>();
        gameObject.AddComponent<Net>();

        DontDestroyOnLoad(gameObject);
    }
}
